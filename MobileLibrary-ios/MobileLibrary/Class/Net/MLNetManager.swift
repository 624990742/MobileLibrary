//
//  File.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import Foundation

let ML_NET_STATE_CODE_SUCCESS = 200
let ML_NET_STATE_CODE_FAILURE = 300
let ML_NET_STATE_CODE_LOGIN = 4000
let ML_NET_STATE_CODE_BACKSTAGEERROR = 2333 //后台返回success = false
let ML_NET_STATE_CODE_BACKSTAGEJSONERROR = 22222222222 //后台返回数据解析失败

enum HTTPResponeCode: Int {
case ML_NET_STATE_CODE_SUCCESS = 200
case ML_NET_STATE_CODE_FAILURE = 300
case ML_NET_STATE_CODE_LOGIN  = 250
}

public class MLNetManager {
    
    var httpResponeCode :HTTPResponeCode = .ML_NET_STATE_CODE_FAILURE
    
    @available(iOS 11.0, *)
    public class func loadNetData<T: TargetType>(API: T.Type, target: T, success: @escaping((Int,Any,String) -> Void),failure: ((Int, String) ->Void)?,cache: Bool = false, cacheCallback: ((Data) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            MLProgressHUD.show()
        }
        
        
        let provider = MoyaProvider<T>(plugins: [
            RequestHandlingPlugin()
        ])
        
        ///处理缓存
         dealCache(cache: cache, target: target) { data in
             if(cache){
                 cacheCallback?(data)
             }else{
                 cacheCallback?(Data())
             }
             
        }
        
        provider.request(target) { result in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                DispatchQueue.main.async {
                    MLProgressHUD.hide()
                }
            }
            switch result {
            case let .success(response):
                
                do {
                    ///moya验证服务器返回成功or失败
                    let code = try response.filterSuccessfulStatusCodes()
                   MLDeugLog(message: "请求返回的指定状态码：\(code)")
                }
                catch let error {
                    ///如果数据获取失败，则返回错误状态码
                    failureCallback(failure: failure, stateCode: response.statusCode, message: error.localizedDescription)
                    return
                }
                
                let result: [String : Any]  = analysisResponseDataResult(responseData: response.data, failure: failure)
                let code = result["code"] as! Int
                let message = result["message"] as? String ?? "数据解析失败"
                if  response.statusCode != 200 {
                    DispatchQueue.main.async {
                        MLProgressHUD.hide()
                    }
                    failureCallback(failure: failure, stateCode: ML_NET_STATE_CODE_BACKSTAGEJSONERROR, message: message)
                    return
                }
                let msg =  result["message"] as! String
                if (code != 200){
                    DispatchQueue.main.async {
                        MLProgressHUD.hide()
                    }
                    MLAlert.show(type: .warning, text:msg)
                    return
                }
                
                //状态码：后台会规定数据正确的状态码，未登录的状态码等，可以统一处理
                switch (response.statusCode) {
                    
            
                case ML_NET_STATE_CODE_SUCCESS ://数据返回正确
                    if cache {//缓存
                        MLPublickTool.save(path: target.path, data: response.data)
                    }
                    success(response.statusCode,result, msg)
                    break
                    
                case ML_NET_STATE_CODE_FAILURE://错误
                    
                    switch message {
                    case "timeOut" ://登录超时
                        MLDeugLog(message: "登录超时,请重新登录")
                    case "limitOut"://在其他地方登录
                        MLDeugLog(message: "登录超时,请重新登录")
                    default :
                        failureCallback(failure: failure, stateCode: response.statusCode, message: message)
                    }
                    break

                default://其他错误
                    failureCallback(failure: failure, stateCode: response.statusCode, message: message)
                    break
                }
                
            case let .failure(error):///请求直接 错误
                let statusCode = error.response?.statusCode ?? 0
                let errorCode = "请求出错，错误码：" + String(statusCode)
                failureCallback(failure: failure, stateCode: statusCode, message: error.errorDescription ?? errorCode)
            }

            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                DispatchQueue.main.async {
                    MLProgressHUD.hide()
                }
            }
            
        }
    }
}


//MARK - 请求失败处理
fileprivate extension MLNetManager {
    
    ///解析服务器返回的结果
    private class func analysisResponseDataResult(responseData: Data,failure: ((Int, String) ->Void)?) -> [String : Any] {
         
     let jsonObj = MLPublickTool.dataToJSONObject(data: responseData)
     
     if jsonObj == nil {
        let errorDict: [String: Any] = [
                          "message":"数据解析错误",
                          "code":String(ML_NET_STATE_CODE_BACKSTAGEJSONERROR),
                          "Data":""]
        return errorDict
      }
        let errorDict: [String: Any] = [
                          "message":"数据解析错误",
                          "code":String(ML_NET_STATE_CODE_BACKSTAGEJSONERROR),
                          "Data":""]
      return jsonObj as? [String : Any] ?? errorDict
    }
}


//MARK - 请求失败处理
fileprivate extension MLNetManager {
    ///错误处理 - 弹出错误信息
   private class func failureCallback(failure: ((Int, String) ->Void)? , stateCode: Int, message: String) {
          var tip = message
          if message.contains("The Internet connection appears to be offline") {
              tip = "网络不给力,请检查您的网络"
          }
          if message.contains("Could not connect to the server") {
              tip = "无法连接服务器"
          }
          if message.contains("The request timed out") {
              tip = "链接超时,无法获取数据"
          }
         
//        MLAlert.show(type: .error, text: tip )
          if let failureBlack = failure {
              failureBlack(stateCode ,tip)
          }
      }
}


fileprivate extension MLNetManager {
    ///处理缓存
  private  class func dealCache<T: TargetType>(cache: Bool = false,target: T,cacheCallback: ((Data) -> Void)? = nil){
        if cache, let data = MLPublickTool.read(path: target.path) { //cacheHandle不为nil则使用cacheHandle处理缓存，否则使用success处理
            if let block = cacheCallback {
                block(data)
            }else {
                MLDeugLog(message: "-- 不处理 --")
            }
        } else {
//                DispatchQueue.main.async {
//                    MLProgressHUD.show()
//                }
        }
    }
}



//MARK - HttpRequest公共参数处理
fileprivate extension MLNetManager {
     // --- 发送请求前,还可以修改/添加 公共参数 ----
      class RequestHandlingPlugin: PluginType {
         /// Called to modify a request before sending
         public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
             var mutateableRequest = request
             return mutateableRequest.appendPublicParams(Withtype: target);
         }
         func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
             
         }
     }
}


//MARK - 公共参数处理
extension URLRequest {
    
    private var commonParams: [String: Any] {
        return [:]
    }
    
    mutating func appendPublicParams(Withtype type :TargetType) -> URLRequest {
        
        let request = try? encoded(parameters: commonParams, parameterEncoding: URLEncoding(destination: .queryString))
        assert(request != nil, "append common params failed, please check common params value")
        return request!
    }
    
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) throws -> URLRequest {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        } catch {
            throw MoyaError.parameterEncoding(error)
        }
    }
    
}



//MARK: - 网络检测
