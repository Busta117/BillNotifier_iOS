//
//  DataRequest.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

public extension DataRequest {
    
    public static func ObjectMapperSerializer<T: BaseMappable>(_ keyPath: String?, mapToObject object: T? = nil, context: MapContext? = nil) -> DataResponseSerializer<T> {
        return DataResponseSerializer { request, response, data, error in
            
            
            if let error = error {
                return .failure(error)
            }
            
            guard let _ = data else {
                let error = AFError.responseSerializationFailed(reason: .inputDataNil)
                return .failure(error)
            }
            
            let JSONResponseSerializer = jsonResponseSerializer(options: JSONSerialization.ReadingOptions.allowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            let JSONToMap: Any?
            if let keyPath = keyPath , keyPath.isEmpty == false {
                JSONToMap = (result.value as AnyObject?)?.value(forKeyPath: keyPath)
            } else {
                JSONToMap = result.value
            }
            
            
            
            if let object = object {
                _ = Mapper<T>().map(JSONObject: JSONToMap, toObject: object)
                return .success(object)
            } else if let parsedObject = Mapper<T>(context: context).map(JSONObject: JSONToMap){
                return .success(parsedObject)
            }
            
            
            let error = AFError.responseSerializationFailed(reason: .inputDataNil)
            
            return .failure(error)
        }
    }
    
    
    /**
     Adds a handler to be called once the request has finished.
     
     - parameter queue:             The queue on which the completion handler is dispatched.
     - parameter keyPath:           The key path where object mapping should be performed
     - parameter object:            An object to perform the mapping on to
     - parameter completionHandler: A closure to be executed once the request has finished and the data has been mapped by ObjectMapper.
     
     - returns: The request.
     */
    @discardableResult
    public func responseObject<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, mapToObject object: T? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        
        
        return response(queue: queue, responseSerializer: DataRequest.ObjectMapperSerializer(keyPath, mapToObject: object, context: context), completionHandler:completionHandler)
    }
    
    
    
    public static func ObjectMapperArraySerializer<T: BaseMappable>(_ keyPath: String?, context: MapContext? = nil) -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { request, response, data, error in
            
            if let error = error {
                return .failure(error)
            }
            
            guard let _ = data else {
                let error = AFError.responseSerializationFailed(reason: .inputDataNil)
                return .failure(error)
            }
            
            
            let JSONResponseSerializer = jsonResponseSerializer(options: JSONSerialization.ReadingOptions.allowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            
            let JSONToMap: Any?
            if let keyPath = keyPath, keyPath.isEmpty == false {
                JSONToMap = (result.value as AnyObject?)?.value(forKeyPath: keyPath)
            } else {
                JSONToMap = result.value
            }
            
            if let parsedObject = Mapper<T>(context: context).mapArray(JSONObject: JSONToMap){
                return .success(parsedObject)
            }
            
            
            //            let failureReason = "ObjectMapper failed to serialize response."
            let error = AFError.responseSerializationFailed(reason: AFError.ResponseSerializationFailureReason.inputDataNil)
            return .failure(error)
        }
    }
    
    
    
    /**
     Adds a handler to be called once the request has finished.
     
     - parameter queue: The queue on which the completion handler is dispatched.
     - parameter keyPath: The key path where object mapping should be performed
     - parameter completionHandler: A closure to be executed once the request has finished and the data has been mapped by ObjectMapper.
     
     - returns: The request.
     */
    @discardableResult
    public func responseArray<T: BaseMappable>(queue: DispatchQueue? = nil, keyPath: String? = nil, context: MapContext? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        
        return response(queue: queue, responseSerializer: DataRequest.ObjectMapperArraySerializer(keyPath, context: context),completionHandler:completionHandler)
        
    }
    
    
}
