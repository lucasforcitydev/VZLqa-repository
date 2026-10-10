const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './testes',

  timeout: 30000,

  use: {
    baseURL: 'https://verzel-store.qa-test-verzel-store.workers.dev',

    browserName: 'chromium',

    screenshot: 'only-on-failure',

    trace: 'retain-on-failure'
  },

  reporter: 'html'
});