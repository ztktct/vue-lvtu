<template>
    <div class="loading-wrap">
        <div class="line-scale">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        </div>
    </div>
    
</template>

<script>
    export default{
        
    } 
</script>

<style>

    .loading-wrap{
        position:absolute;
        z-index:88;
        top:0;
        right:0;
        bottom:0;
        left:0;
        background:rgba(0,0,0,.3);
        display:flex;
        justify-content:center;
        align-items:center;
    }

    @-webkit-keyframes line-scale {
  0% {
    -webkit-transform: scaley(1);
            transform: scaley(1); }

  50% {
    -webkit-transform: scaley(0.4);
            transform: scaley(0.4); }

  100% {
    -webkit-transform: scaley(1);
            transform: scaley(1); } }
@keyframes line-scale {
  0% {
    -webkit-transform: scaley(1);
            transform: scaley(1); }

  50% {
    -webkit-transform: scaley(0.4);
            transform: scaley(0.4); }

  100% {
    -webkit-transform: scaley(1);
            transform: scaley(1); } }

.line-scale > div:nth-child(1) {
  -webkit-animation: line-scale 1s 0.1s infinite cubic-bezier(.2, .68, .18, 1.08);
          animation: line-scale 1s 0.1s infinite cubic-bezier(.2, .68, .18, 1.08); }
.line-scale > div:nth-child(2) {
  -webkit-animation: line-scale 1s 0.2s infinite cubic-bezier(.2, .68, .18, 1.08);
          animation: line-scale 1s 0.2s infinite cubic-bezier(.2, .68, .18, 1.08); }
.line-scale > div:nth-child(3) {
  -webkit-animation: line-scale 1s 0.3s infinite cubic-bezier(.2, .68, .18, 1.08);
          animation: line-scale 1s 0.3s infinite cubic-bezier(.2, .68, .18, 1.08); }
.line-scale > div:nth-child(4) {
  -webkit-animation: line-scale 1s 0.4s infinite cubic-bezier(.2, .68, .18, 1.08);
          animation: line-scale 1s 0.4s infinite cubic-bezier(.2, .68, .18, 1.08); }
.line-scale > div:nth-child(5) {
  -webkit-animation: line-scale 1s 0.5s infinite cubic-bezier(.2, .68, .18, 1.08);
          animation: line-scale 1s 0.5s infinite cubic-bezier(.2, .68, .18, 1.08); }
.line-scale > div {
  background-color: #fff;
  width: 4px;
  height: 35px;
  border-radius: 2px;
  margin: 2px;
  -webkit-animation-fill-mode: both;
          animation-fill-mode: both;
  display: inline-block; }
</style>