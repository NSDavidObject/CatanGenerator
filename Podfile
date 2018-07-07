platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
    pod 'Fabric'
    pod 'SnapKit'
    pod 'Crashlytics'
    pod 'SwiftLint'
    #pod 'CommonUtilities', :git => "git@github.com:NSDavidObject/CommonUtilities.git"
    pod 'CommonUtilities', :path => "../CommonUtilities/"
end

target "Catan" do
    shared_pods
end

target "CatanTests" do
	shared_pods
end