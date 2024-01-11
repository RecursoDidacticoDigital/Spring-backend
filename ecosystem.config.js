module.exports = {
    apps: [
      {
        name: '8085-strapi-api',
        script: 'java',
        args: ['-jar', 'api/target/strapi-api-1.jar','--server.port=8085'],
        exec_mode: 'fork', 
      }
    ],
  };
  