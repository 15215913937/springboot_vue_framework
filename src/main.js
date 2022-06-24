import {createApp} from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementPlus from 'element-plus'
import zhCn from 'element-plus/es/locale/lang/zh-cn'
import 'element-plus/dist/index.css'


//导入该路径下的css全局配置
import '@/assets/css/global.css'

createApp(App).use(store).use(router).use(ElementPlus, {locale: zhCn,}).mount('#app')
