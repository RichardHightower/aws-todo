import { createApp } from "vue";
import App from "./App.vue";
import "./registerServiceWorker";
import router from "./router";
import store from "./store";
import axios from "axios";

axios.defaults.baseURL = process.env.VUE_APP_API_BASE_URL;

createApp(App).use(store).use(router).mount("#app");
