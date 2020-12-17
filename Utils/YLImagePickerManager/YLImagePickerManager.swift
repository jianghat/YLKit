//
//  YLImagePickerManager.swift
//  Driver
//
//  Created by ym on 2020/11/5.
//

import UIKit

typealias YLImagePickerManagerBlock = (_ info: [UIImagePickerController.InfoKey : Any]?, _ isCancel: Bool)->Void

class YLImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker: UIImagePickerController?;
    var completionBlock: YLImagePickerManagerBlock?;
    
    class var sharedInstance: YLImagePickerManager {
        struct Static {
            static let instance = YLImagePickerManager();
        }
        return Static.instance
    }
    
    override init() {
        super.init();
        imagePicker = UIImagePickerController();
        imagePicker!.allowsEditing = false;
        imagePicker!.delegate = self;
        imagePicker?.sourceType = .photoLibrary;
    }
    
    @discardableResult
    class func showActionSheet(in controller: UIViewController!, _ title: String?, block: @escaping YLImagePickerManagerBlock) -> UIAlertController {
        let actionSheet = UIAlertController.actionSheet(title, message: nil, cancelButtonTitle: "取消", otherButtonTitles: ["拍照", "从相册中选取"]);
        actionSheet.tapIndexBlock = { (index) in
            let sourceType: Int = index as! Int;
            YLImagePickerManager.show(in: controller, sourceType, block: block);
        }
        actionSheet.show(in: controller);
        return actionSheet
    }
    
    class func show(in controller: UIViewController!, _ sourceType: Int, block: @escaping YLImagePickerManagerBlock) {
        YLImagePickerManager.sharedInstance.show(in: controller, sourceType, block: block);
    }
    
    func show(in controller: UIViewController!, _ sourceType: Int, block: @escaping YLImagePickerManagerBlock) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return };
        self.completionBlock = block;
        if sourceType == 0 {
            imagePicker!.sourceType = .camera;
        } else {
            imagePicker?.sourceType = .photoLibrary;
        }
        controller.present(imagePicker!, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true) { [weak self] in
            if self?.completionBlock != nil {
                self?.completionBlock!(info, false);
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            if self.completionBlock != nil {
                self.completionBlock!(nil, true);
            }
        };
    }
}
