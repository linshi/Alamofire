//
//  DownloadManager.swift
//  iOS Example
//
//  Created by Lin Shi on 13/10/2015.
//  Copyright © 2015 Alamofire. All rights reserved.
//

import Alamofire

extension Request{
    
    public class func suggestedDownloadedDestination(
        directory directory: NSSearchPathDirectory = .DocumentDirectory,
        domain: NSSearchPathDomainMask = .UserDomainMask)
        -> DownloadFileDestination
    {
        return { temporaryURL, response -> NSURL in
            let directoryURLs = NSFileManager.defaultManager().URLsForDirectory(directory, inDomains: domain)
            
            if !directoryURLs.isEmpty {
                let downloadedDir:NSURL = directoryURLs[0].URLByAppendingPathComponent("Downloaded", isDirectory: true)
                if NSFileManager.defaultManager().fileExistsAtPath(downloadedDir.absoluteString) == false {
                    do {
                        try NSFileManager.defaultManager().createDirectoryAtURL(downloadedDir, withIntermediateDirectories: false, attributes: nil)
                    }catch{
                        print("failed to create downloaded dir")
                    }
                }
                return directoryURLs[0].URLByAppendingPathComponent("Downloaded", isDirectory: true).URLByAppendingPathComponent(response.suggestedFilename!)
            }
            
            return temporaryURL
        }
    }
    
    
}

class DownloadOperation: NSOperation {
    var remoteContentURL:String? = nil
    
    let cachesDirectory = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first
    
    let downloadingDir:NSURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent("downloading", isDirectory: true))!
    
    let downloadedDir:NSURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent("downloaded", isDirectory: true))!
    
    init(url:String?){
        if let _ = url {
            self.remoteContentURL = url
        }
    }
    
    override func main() {
        
        if self.remoteContentURL != nil && self.cancelled == false {
            
            Alamofire.download(.GET, self.remoteContentURL!, destination: Alamofire.Request.suggestedDownloadedDestination()).response{ (request, response, data, error) -> Void in
                if response?.statusCode == 200 {
                    print("request : \(request)")
                    print("response : \(response)")
                    print("data: \(data)")
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("update_progress", object: request)
                    
                }else{
                    print("error: \(error)")
                    NSNotificationCenter.defaultCenter().postNotificationName("download_failed", object: request)

                }
            }
            
        }
        
    }
}

class DownloadManager {
    var downloadQueue = NSOperationQueue()
    var downloadURLArray:Array<String>?
    
    init(downloadURLArray:Array<String>?){
        self.downloadURLArray = downloadURLArray
    }
    
    func start(){
        if let urlArray = downloadURLArray as Array<String>! {
            for url in urlArray{
                let op = DownloadOperation(url: url)
                downloadQueue .addOperation(op)
            }
        }
    }
    
    func stop(){
        if let runningQueue = self.downloadQueue as NSOperationQueue!   {
            runningQueue.cancelAllOperations()
        }
    }
}