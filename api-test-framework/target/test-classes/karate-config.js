function fn() {
    var config = {
        baseUrl: 'http://localhost:8080',
        timeout: 5000,
        logLevel: 'INFO'
    };

    // Environment-specific configuration
    var env = karate.env;

    if (env === 'dev') {
        config.baseUrl = 'http://localhost:3000';
        config.timeout = 3000;
        config.logLevel = 'DEBUG';
    } 
    else if (env === 'staging') {
        config.baseUrl = 'https://api-staging.example.com';
        config.timeout = 5000;
        config.logLevel = 'INFO';
    } 
    else if (env === 'prod') {
        config.baseUrl = 'https://api.example.com';
        config.timeout = 10000;
        config.logLevel = 'WARN';
    }

    karate.log('Running tests against: ' + config.baseUrl);
    return config;
}
