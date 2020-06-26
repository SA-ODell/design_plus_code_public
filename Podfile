source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

def common_pods
    pod 'RealmSwift', '3.0.0'
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/RemoteConfig'
    pod 'Firebase/Messaging'
end

target 'DesignCodeApp' do
	common_pods
    pod 'Kingfisher'
    pod 'MKRingProgressView'
    pod 'TPKeyboardAvoiding'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'ReachabilitySwift'
    pod 'LifetimeTracker', '1.2.1'
    pod 'Ambience'
    pod 'Disk'
    pod 'netfox'
    pod 'Purchases'
    pod 'Zip'
end

target 'DesignCodeAppTests' do
  inherit! :search_paths
  common_pods
end

target 'DesignCodeAppUITests' do
  inherit! :search_paths
  common_pods
end
