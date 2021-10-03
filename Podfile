# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TrackMedicine' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TrackMedicine
  pod 'ReactiveSwift'
  pod 'Moya/ReactiveSwift'
  pod 'ReactiveCocoa'
  pod 'Swinject'
  pod 'SwiftLint'
  pod 'MBProgressHUD', '~> 1.2'
  pod 'RealmSwift'
  def testing_pods
      pod 'Quick'
      pod 'Nimble', '~> 9.0.1'
  end

  target 'TrackMedicineTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'TrackMedicineUITests' do
    # Pods for testing
  end

end
