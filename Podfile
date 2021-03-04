platform :ios, '13.0'
inhibit_all_warnings!

target 'WeatherApp' do
  use_frameworks!

  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics' 
  pod 'Firebase/Performance'

  target 'WeatherAppIntegrationTests' do
    inherit! :search_paths
  end

  target 'WeatherAppSnapshotTests' do
    inherit! :search_paths
    pod 'SnapshotTesting', '~> 1.8.0'
  end

  target 'WeatherAppUITests' do
  end

  target 'WeatherAppUnitTests' do
    inherit! :search_paths
  end

end
