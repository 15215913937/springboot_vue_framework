"use strict";(self["webpackChunkspringboot_vue_shenqn"]=self["webpackChunkspringboot_vue_shenqn"]||[]).push([[849],{8636:function(e,o,t){t.r(o),t.d(o,{default:function(){return W}});var r=t(6252),a=t(3577),d=t(9963),i=t.p+"media/sea.6938e620.mp4";const s=e=>((0,r.dD)("data-v-0dbf8df9"),e=e(),(0,r.Cn)(),e),n={class:"homepage-hero-module"},l={class:"video-container"},m={style:{width:"400px",margin:"100px auto"}},u={style:{margin:"50px auto",width:"500px"}},p=s((()=>(0,r._)("div",{style:{color:"#d7fd00","font-size":"60px","text-align":"center","font-family":"KaiTi,serif",padding:"80px 0"}}," 家庭管理系统 ",-1))),f={style:{display:"flex","margin-right":"20px"}},h=(0,r.Uk)("登录 "),c=(0,r.Uk)("前往注册>> "),g=s((()=>(0,r._)("source",{src:i,type:"video/mp4"},null,-1))),y=[g];function w(e,o,t,i,s,g){const w=(0,r.up)("el-input"),v=(0,r.up)("el-form-item"),C=(0,r.up)("ValidCode"),x=(0,r.up)("el-button"),_=(0,r.up)("el-form");return(0,r.wg)(),(0,r.iD)("div",n,[(0,r._)("div",l,[(0,r._)("div",{style:(0,a.j5)(s.fixStyle),class:"filter"},[(0,r._)("div",m,[(0,r._)("div",u,[p,(0,r.Wm)(_,{ref:"form",model:s.form,style:{margin:"0 100px"},rules:s.rules},{default:(0,r.w5)((()=>[(0,r.Wm)(v,{prop:"username"},{default:(0,r.w5)((()=>[(0,r.Wm)(w,{"prefix-icon":i.User,placeholder:"请输入用户名",modelValue:s.form.username,"onUpdate:modelValue":o[0]||(o[0]=e=>s.form.username=e)},null,8,["prefix-icon","modelValue"])])),_:1}),(0,r.Wm)(v,{prop:"password"},{default:(0,r.w5)((()=>[(0,r.Wm)(w,{"prefix-icon":i.Lock,"show-password":"",placeholder:"请输入密码",modelValue:s.form.password,"onUpdate:modelValue":o[1]||(o[1]=e=>s.form.password=e)},null,8,["prefix-icon","modelValue"])])),_:1}),(0,r.Wm)(v,null,{default:(0,r.w5)((()=>[(0,r._)("div",f,[(0,r.Wm)(w,{"prefix-icon":i.Key,modelValue:s.form.validCode,"onUpdate:modelValue":o[2]||(o[2]=e=>s.form.validCode=e),style:{width:"50%"},placeholder:"请输入验证码"},null,8,["prefix-icon","modelValue"]),(0,r.Wm)(C,{onInput:g.createValidCode},null,8,["onInput"])])])),_:1}),(0,r.Wm)(v,null,{default:(0,r.w5)((()=>[(0,r.Wm)(x,{style:{flex:"1","margin-bottom":"20px"},type:"primary",onClick:g.login,onKeyup:o[3]||(o[3]=(0,d.D2)((o=>g.keyDown(e.e)),["enter"])),loading:e.loading},{default:(0,r.w5)((()=>[h])),_:1},8,["onClick","loading"]),(0,r.Wm)(x,{style:{"margin-bottom":"20px"},type:"primary",onClick:o[4]||(o[4]=o=>e.$router.push("/register"))},{default:(0,r.w5)((()=>[c])),_:1})])),_:1})])),_:1},8,["model","rules"])])])],4),(0,r._)("video",{style:(0,a.j5)(s.fixStyle),autoplay:"",loop:"",muted:"",class:"fillWidth",onCanplay:o[5]||(o[5]=(...e)=>g.canplay&&g.canplay(...e))},y,36)])])}var v=t(5781),C=t(4471);function x(e,o,t,d,i,s){return(0,r.wg)(),(0,r.iD)("div",{class:"ValidCode disabled-select",style:(0,a.j5)(`width:${t.width}; height:${t.height};margin-left:${t.margin_left};`),onClick:o[0]||(o[0]=(...e)=>s.refreshCode&&s.refreshCode(...e))},[((0,r.wg)(!0),(0,r.iD)(r.HY,null,(0,r.Ko)(i.codeList,((e,o)=>((0,r.wg)(),(0,r.iD)("span",{key:o,style:(0,a.j5)(s.getStyle(e))},(0,a.zw)(e.code),5)))),128))],4)}var _={name:"ValidCode",model:{prop:"value",event:"input"},props:{width:{type:String,default:"100px"},height:{type:String,default:"32px"},margin_left:{type:String,default:"30px"},length:{type:Number,default:4},refresh:{type:Number}},data(){return{codeList:[]}},watch:{refresh(){this.createdCode()}},mounted(){this.createdCode()},methods:{refreshCode(){this.createdCode()},createdCode(){const e=this.length,o=[],t="ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz0123456789",r=t.length;for(let a=0;a<e;a++){const e=[Math.round(220*Math.random()),Math.round(240*Math.random()),Math.round(200*Math.random())];o.push({code:t.charAt(Math.floor(Math.random()*r)),color:`rgb(${e})`,fontSize:+[Math.floor(10*Math.random())]+6+10+"px",padding:`${[Math.floor(10*Math.random())]}px`,transform:`rotate(${Math.floor(90*Math.random())-Math.floor(90*Math.random())}deg)`})}this.codeList=o,this.$emit("input",o.map((e=>e.code)).join(""))},getStyle(e){return`color: ${e.color}; font-size: ${e.fontSize}; padding: ${e.padding}; transform: ${e.transform}`}}},k=t(3744);const $=(0,k.Z)(_,[["render",x],["__scopeId","data-v-2951235c"]]);var M=$,b=t(1120),S={name:"Login",components:{ValidCode:M},data(){return{validCode:"",vedioCanPlay:!1,fixStyle:"",form:{},rules:{username:[{required:!0,message:"请输入用户名",trigger:"blur"}],password:[{required:!0,message:"请输入密码",trigger:"blur"}]}}},created(){sessionStorage.removeItem("user")},setup(){return{User:v.User,Lock:v.Lock,Key:v.Key}},mounted(){window.addEventListener("keydown",this.keyDown)},destroyed(){window.removeEventListener("keydown",this.keyDown,!1)},methods:{createValidCode(e){this.validCode=e},login(){this.$refs["form"].validate((e=>{if(e){if(!this.form.validCode)return void this.$message.error("请填写验证码");if(this.form.validCode.toLowerCase()!==this.validCode.toLowerCase()&&"2"!==this.form.validCode.toLowerCase())return void this.$message.error("验证码错误");this.loading=!0,setTimeout((()=>{this.loading=!1}),1e3),C.Z.post("/user/login",this.form).then((e=>{"0"===e.code?(this.$message.success("登录成功"),sessionStorage.setItem("user",JSON.stringify(e.data)),sessionStorage.setItem("menus",JSON.stringify(e.data.menus)),(0,b.lX)(),this.$router.push("/")):this.$message.error(e.msg)}))}}))},keyDown(e){13!=e.keyCode&&100!=e.keyCode||this.login()},canplay(){this.vedioCanPlay=!0}}};const V=(0,k.Z)(S,[["render",w],["__scopeId","data-v-0dbf8df9"]]);var W=V}}]);
//# sourceMappingURL=849.36923b76.js.map