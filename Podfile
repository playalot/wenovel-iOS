platform :ios, '8.0'
use_frameworks!

def baseframework 
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'ObjectMapper'
end

def netframework 
    pod 'Alamofire'
end

def authframework
    pod 'Simplicity'
    pod 'MonkeyKing'
    # pod 'OAuthSwift'
end


def uiframework
    pod 'YYWebImage'
    pod 'YYImage/WebP'
    pod 'IBAnimatable'
    pod 'FDFullscreenPopGesture'
    pod 'YYText'
    pod 'SVProgressHUD'
    pod 'IQKeyboardManagerSwift'
    pod 'SnapKit'
end

def cacheframework
    pod 'YYCache'
    pod 'KeychainAccess'
end

target 'WeNovel' do
    pod 'R.swift'
    baseframework
    uiframework
end

target 'WeNovelKit' do
    baseframework
    authframework
end

target 'NetworkService' do
    baseframework
    netframework
end

target 'CacheService' do
    cacheframework
end
