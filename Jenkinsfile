pipeline {
  agent { label 'iOS' }

  environment {
    OPEN_WEATHER_API_KEY = credentials('OPEN_WEATHER_API_KEY')
    SONAR_TOKEN = credentials('SONAR_TOKEN')
  }
  
  options {
    parallelsAlwaysFailFast()
  }

  stages {

    stage('Env') {
      steps { 
        sh 'set'
        sh 'cp WeatherApp/Preferences/Secrets_example.plist WeatherApp/Preferences/Secrets.plist'
        sh '/usr/libexec/PlistBuddy -c "Set :OpenWeatherAPIKey ${OPEN_WEATHER_API_KEY}" WeatherApp/Preferences/Secrets.plist'
      }
    }
    
    stage('Lint') {
      steps {
        sh 'bundle exec fastlane lint'
      }
    }

    stage('Test') {
      steps {
        sh 'bundle exec fastlane tests'
      }
      post {
        always {
          script {
            junit '**/*/report.junit'
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
