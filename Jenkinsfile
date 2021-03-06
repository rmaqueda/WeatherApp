pipeline {
  agent { label 'iOS' }

  environment {
    KEYCHAIN_PASSWORD = credentials('KEYCHAIN_PASSWORD')
    OPEN_WEATHER_API_KEY = credentials('OPEN_WEATHER_API_KEY')
    BROWSERSTACK_USER = credentials('BROWSERSTACK_USER')
    BROWSERSTACK_KEY = credentials('BROWSERSTACK_KEY')
  }
  
  options {
    parallelsAlwaysFailFast()
  }

  stages {

    stage('Env') {
      steps { 
        sh 'set'
        sh 'security unlock-keychain -p ${KEYCHAIN_PASSWORD} ${HOME}/Library/Keychains/login.keychain'
        sh 'cp WeatherApp/Preferences/Secrets_example.plist WeatherApp/Preferences/Secrets.plist'
        sh '/usr/libexec/PlistBuddy -c "Set :OpenWeatherAPIKey ${OPEN_WEATHER_API_KEY}" WeatherApp/Preferences/Secrets.plist'
      }
    }

    stage('CocoaPods') {
      steps { sh 'pod install' }
    }
    
    stage('Lint') {
      steps { sh 'bundle exec fastlane lint' }
    }

    stage('Archive for test') {
    	when { expression { isDevelop() || isRelease() || isMain() || isMaster() } }
      steps { sh 'bundle exec fastlane archive_for_tests' }
    }

    stage('Run tests') {
      parallel {
        stage('Test Simulator') {
          steps { sh 'bundle exec fastlane tests' }
          post {
            always {
              script {
                junit 'test/report.junit'
                archiveArtifacts artifacts: 'logs/**/**.log', fingerprint: true
              }
            }
          }
        }

        stage('Test Device') {
          when { expression { isDevelop() || isRelease() || isMain() || isMaster() } }
          steps {
            sh 'Scripts/browserstack.sh ${BROWSERSTACK_USER} ${BROWSERSTACK_KEY}'
          }
        }
      }
    }

  }

  post {
    always {
      emailext  body: '''${SCRIPT, template="build-report.groovy"}''',
      subject: '[Jenkins FP] ${JOB_NAME}',
      recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]
    }
    cleanup {
      cleanWs()
    }
  }

}

def isPR() {
  return env.CHANGE_ID
}

def isDevelop() {
  return env.BRANCH_NAME ==~ "develop"
}

def isRelease() {
  return env.BRANCH_NAME ==~ "release/.*"
}

def isMain() {
  return env.BRANCH_NAME ==~ "main"
}

def isMaster() {
  return env.BRANCH_NAME ==~ "master"
}
