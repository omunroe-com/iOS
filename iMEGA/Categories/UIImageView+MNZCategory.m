
#import "UIImageView+MNZCategory.h"

#import "Helper.h"
#import "MEGASdkManager.h"
#import "UIImage+MNZCategory.h"
#import "UIImage+GKContact.h"

@implementation UIImageView (MNZCategory)

- (void)mnz_setImageForUserHandle:(uint64_t)userHandle {
    [self mnz_setImageForUserHandle:userHandle name:@"?"];
}

- (void)mnz_setImageForUserHandle:(uint64_t)userHandle name:(NSString *)name {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.masksToBounds = YES;
    
    self.image = [UIImage mnz_imageForUserHandle:userHandle name:name size:self.frame.size delegate:self];
}

- (void)mnz_setThumbnailByNode:(MEGANode *)node {
    if (node.hasThumbnail) {
        NSString *thumbnailFilePath = [[Helper pathForSharedSandboxCacheDirectory:@"thumbnailsV3"] stringByAppendingPathComponent:node.base64Handle];
        if ([[NSFileManager defaultManager] fileExistsAtPath:thumbnailFilePath]) {
            self.image = [UIImage imageWithContentsOfFile:thumbnailFilePath];
        } else {            
            [self mnz_setImageForExtension:node.name.pathExtension];
            if (node) {
                [[MEGASdkManager sharedMEGASdk] getThumbnailNode:node destinationFilePath:thumbnailFilePath delegate:self];
            }
        }
    } else {
        [self mnz_setImageForExtension:node.name.pathExtension];
    }
}

- (void)mnz_setImageForExtension:(NSString *)extension {
    extension = extension.lowercaseString;
    UIImage *image;
    if ([extension isEqualToString:@"jpg"] || [extension isEqualToString:@"jpeg"]) {
        image = [Helper defaultPhotoImage];
    } else {
        NSDictionary *fileTypesDictionary = [Helper fileTypesDictionary];
        NSString *filetypeImage = [fileTypesDictionary valueForKey:extension];
        if (filetypeImage && filetypeImage.length > 0) {
            image = [UIImage imageNamed:filetypeImage];
        } else {
            image = [Helper genericImage];
        }
    }
    
    self.image = image;
}

- (void)mnz_imageForNode:(MEGANode *)node {
    switch (node.type) {
        case MEGANodeTypeFolder: {
            if ([node.name isEqualToString:@"Camera Uploads"]) {
                self.image = [Helper folderCameraUploadsImage];
            } else {
                if (node.isInShare) {
                    self.image = [Helper incomingFolderImage];
                } else if (node.isOutShare) {
                    self.image = [Helper outgoingFolderImage];
                } else {
                    self.image = [Helper folderImage];
                }
            }
            break;
        }
            
        case MEGANodeTypeFile:
            [self mnz_setImageForExtension:node.name.pathExtension];
            break;
            
        default:
            self.image = [Helper genericImage];
    }
}

#pragma mark - MEGARequestDelegate

- (void)onRequestFinish:(MEGASdk *)api request:(MEGARequest *)request error:(MEGAError *)error {
    if (error.type != MEGAErrorTypeApiOk) {
        return;
    }
    
    if (request.type == MEGARequestTypeGetAttrUser || request.type == MEGARequestTypeGetAttrFile) {
        self.image = [UIImage imageWithContentsOfFile:request.file];
    }
}

@end
