# Import OAuth2 access tokens into Apigee Edge
This is a utility for [Apigee Edge](https://cloud.google.com/apigee-api-management/) and provides a way to import or migrate OAuth2 access tokens from external authorization servers into Edge.
Typical use cases are: 
1. Access tokens from an external authorization server need to be imported or migrated into Edge. 
2. Access tokens from a customer managed Edge instance need to migrated to Apigee managed Edge instance

## Solution
The idea is to use the [OAuthV2](http://docs.apigee.com/api-services/content/oauthv2-policy#externalaccesstokenelement) policy in the [external authorization mode](http://docs.apigee.com/api-services/content/use-third-party-oauth-system#howtousethirdpartyoauthonapigee). 
The import-token proxy uses OAuthV2 policy in external authorization mode and adds an access token into Edge so that at runtime the imported token should behave like native edge tokens. A script can then be used to send all the access tokens to be imported/migrated to import-token proxy. The script is not included as part of this project.
The proxy and the script can be used as part of migration activity and once all tokens are imported, at runtime, these tokens can be used just like native Edge tokens.
The OAuthV2 policy needs a client Id (the app consumer key) so the association between an access token and an application on Edge is correctly maintained.

## Extensions
The tool shows how the client credentials access token can be imported into Edge. It can be easily extended to other OAuth2 grant types as well as to import of refresh tokens and authorization codes.

## Setup

### Maven
[Download]() and [install]() Apache Maven.

### Git
Clone/Download this repo.

### Deploy
Modify the token-import/src/gateway/shared-pom.xml to set up a profile for deployment. For details see [apigee-maven-deploy-plugin](https://github.com/apigee/apigee-deploy-maven-plugin)

To deploy the proxies, open command prompt:
```
$ cd token-import/src/gateway/<proxy>
$ mvn install -P<profile> -Dusername=<Edge username> -Dpassword=<Edge password> -Dorg=<Edge org> -Denv=<Edge env> -Doptions=<validate, update> 
```

### Configuration
To deploy the required API product, developer and application:
```
$ cd token-import/config
$ mvn install -P<profile> -Dusername=<Edge username> -Dpassword=<Edge password> -Dorg=<Edge org> -Denv=<Edge env> -Dapigee.config.options=<create/update/delete/sync>
```

### Testing
The project uses [apickli](https://github.com/apickli/apickli) a BDD style REST API integration testing framework based on [Cucumber.js](https://github.com/cucumber/cucumber-js).

#### Install Node JS
[Download](https://nodejs.org/en/download/) and install NodeJS. NPM should be installed as part of it.

#### Grunt
Install Grunt, a build tool.
```
$ npm install -g grunt-cli
```

#### Cucumber
Install CucumberJS for BDD style and Gerkhin language support.
```
$ npm install -g cucumber
```

#### Dependencies
Get dependencies in package.json by npm install.
```
$ cd token-import/test/bdd
$ npm install
```

#### App Key
Update APP_KEY variable on "test/bdd/features/step_definitions/token-import-steps.js" file to reflect an application consumer key from Edge. It is the consumer key of ImportTokenTestApp if you had run the configuration step previously.

#### Run
Run tests using below command.
```
$ cd token-import/test/bdd
$ grunt
```



