//
//  YLBleDevice.swift
//  Driver
//
//  Created by ym on 2020/12/2.
//

import UIKit
import CoreBluetooth

//蓝牙设备协议
protocol YLBleDeviceDelegate: NSObjectProtocol {
    func deviceDidBecomeReady(_ device: YLBleDevice)
}

class YLBleDevice: NSObject {
    //MARK:公共属性
    public var name: String?
    public var peripheral: CBPeripheral?
    
    var delegate: YLBleDeviceDelegate?
    
    //私有属性
    private var needDiscoverServices: NSMutableArray?
    private var allCharacteristics: NSMutableArray!
    private var readBlockDic: [String: YLReadDeviceInfoBlock] = [:]
    private var writeBlockDic: [String: YLWriteDeviceBlock] = [:]
    
    init( _ peripheral: CBPeripheral?) {
        self.name = peripheral?.name
        self.peripheral = peripheral
        self.allCharacteristics = NSMutableArray()
    }
}

//MARK:-公共方法
extension YLBleDevice {
    //读取设备信息
    public func readDeviceInfo(_ uuid: String, complete:@escaping (_ object: Data?) -> Void) {
        guard let peripheral = self.peripheral else { return }
        let readInfoBlock = {(object: Data?) in
            complete(object)
        }
        readBlockDic[uuid] = readInfoBlock
        let characteristic = self.characteristicWithUUID(uuid)
        guard let myCharacteristic = characteristic  else {
            complete(nil)
            debug_log("没有发现该特性")
            return
        }
        peripheral.readValue(for: myCharacteristic)
    }
    
    //写入数据
    public func writeDevice(_ uuid: String, bytes: [UInt8], writeDeviceBlock: @escaping YLWriteDeviceBlock) {
        guard let peripheral = self.peripheral else { return }
        writeBlockDic[uuid] = writeDeviceBlock
        let characteristic = self.characteristicWithUUID(uuid)
        guard let myCharacteristic = characteristic  else {
            debug_log("没有发现该特性")
            return
        }
        let data = Data(bytes: bytes, count: bytes.count)
        peripheral.writeValue(data, for: myCharacteristic, type: CBCharacteristicWriteType.withResponse)
    }
}

//MARK:-私有方法
extension YLBleDevice {
    //根据characteristicUUID获取characteristic
    private func characteristicWithUUID(_ uuid: String) -> CBCharacteristic? {
        for characteristic in self.allCharacteristics {
            let bleCharacteristic  = characteristic as! CBCharacteristic
            if bleCharacteristic.uuid.uuidString == uuid {
                return bleCharacteristic
            }
        }
        return nil
    }
}

//MARK:-蓝牙设备协议
extension YLBleDevice: CBPeripheralDelegate {
    //发现设备服务协议
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        debug_log("发现服务")
        guard let services = peripheral.services else { return }
        needDiscoverServices = NSMutableArray(array: services)
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    //发现服务下的特性值协议
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        debug_log("发现特性")
        if needDiscoverServices != nil {
            needDiscoverServices?.remove(service)
            if needDiscoverServices!.count <= 0  {
                debug_log("设备准备就绪")
                let bleDevice = YLBleDevice(peripheral)
                self.delegate?.deviceDidBecomeReady(bleDevice)
            }
        }
        //把发现的所有特性保存起来
        guard let characteristics = service.characteristics else { return }
        self.allCharacteristics.addObjects(from: characteristics)
    }
    
    //特性值读取成功协议
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let value = characteristic.value
        let uuid = characteristic.uuid.uuidString
        let readDeviceInfoBlock =  readBlockDic[uuid]
        readDeviceInfoBlock?(value)
    }
    
    //写入成功协议
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        var success: Bool = true
        if error != nil {
            success = false
        }
        let uuid = characteristic.uuid.uuidString
        let writeDeviceBlock =  writeBlockDic[uuid]
        if writeDeviceBlock != nil {
            writeDeviceBlock!(success)
        }
    }
}
