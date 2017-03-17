/* jslint node: true */
'use strict';

var apickli = require('apickli');
var prettyJson = require('prettyjson');
var jsonPath = require('JSONPath');

var stepContext = {};

var APP_KEY = "HBAA097vtNWUP11Q9pMNH6TqeHgUmqxd";

module.exports = function() {

    // cleanup before every scenario
    this.Before(function(scenario, callback) {
        this.apickli = new apickli.Apickli('https', 'srinisref-test.apigee.net');
        this.apickli.storeValueInScenarioScope("APP_KEY", APP_KEY);
        callback();
    });

    this.Given(/^I set query parameter (.*) to (.*)$/, function(param, value, callback) {
    	  var obj = {};
    	  obj.parameter = param;
    	  obj.value = value;
    	  var arr = [];
    	  arr.push(obj);
        this.apickli.setQueryParameters(arr);
        callback();
    });

    this.Given(/^I set form data to$/, function(formParameters, callback) {
        this.apickli.addRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        var content = formParameters.hashes().map(function(d) {
          return d.name + "=" + d.value;
        }).join("&");
        this.apickli.setRequestBody(content);
        callback();
    });

    this.Given(/^I set json data to$/, function(formParameters, callback) {
        this.apickli.addRequestHeader("Content-Type", "application/json");
        var content = formParameters.hashes().reduce(function(obj, d) {
            obj[d.name] = d.value;
            return obj
        }, {});
        this.apickli.setRequestBody(JSON.stringify(content));
        callback();
    });

};
