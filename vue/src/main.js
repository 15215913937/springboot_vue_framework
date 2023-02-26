import {createApp} from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
//导入该路径下的css全局配置
import '@/assets/css/global.css'
import VueParticles from 'vue-particles'
import mavonEditor from 'mavon-editor'


const app = createApp(App);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}

app
    .use(store)
    .use(router)
    .use(ElementPlus, {locale: zhCn,})
    .use(VueParticles)
    .use(mavonEditor)
    // .use(request)
    .mount('#app');
