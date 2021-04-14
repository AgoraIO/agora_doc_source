---
title: 实现音频直播
platform: Android
updatedAt: 2020-12-16 03:49:27
---
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-c3ow{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-fymr{border-color:inherit;font-weight:bold;text-align:left;vertical-align:top}
.tg .tg-7btt{border-color:inherit;font-weight:bold;text-align:center;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg" style="undefined;table-layout: fixed; width: 752px">
<colgroup>
<col style="width: 211px">
<col style="width: 177px">
<col style="width: 67px">
<col style="width: 101px">
<col style="width: 81px">
<col style="width: 115px">
</colgroup>
<thead>
  <tr>
    <th class="tg-fymr"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">游戏场景</span></th>
    <th class="tg-fymr">典型游戏</th>
    <th class="tg-7btt">画质档位</th>
    <th class="tg-7btt"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">视频帧率 (fps)</span></th>
    <th class="tg-7btt"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">视频分辨率</span></th>
    <th class="tg-7btt"><span style="font-weight:bold;color:#333;background-color:#F4F5F7">视频码率 (Kbps)</span></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky" rowspan="2">场景 1: 复杂游戏<br></td>
    <td class="tg-0pky" rowspan="2">跑酷类游戏<br><br><span style="font-weight:normal;font-style:normal;text-decoration:none">赛车类游戏</span><br><br>如神庙逃亡、地铁跑酷<br></td>
    <td class="tg-c3ow">流畅</td>
    <td class="tg-c3ow">24</td>
    <td class="tg-c3ow">640 × 360</td>
    <td class="tg-c3ow">1800 ~ 2200</td>
  </tr>
  <tr>
    <td class="tg-c3ow">高清</td>
    <td class="tg-c3ow">24</td>
    <td class="tg-c3ow">840 × 480</td>
    <td class="tg-c3ow">2600 ~ 2800</td>
  </tr>
  <tr>
    <td class="tg-0pky" rowspan="2">场景 2: 单一游戏<br></td>
    <td class="tg-0pky" rowspan="2">愤怒的小鸟<br><br>贪吃蛇大作战</td>
    <td class="tg-c3ow">流畅</td>
    <td class="tg-c3ow">10</td>
    <td class="tg-c3ow">840 × 480</td>
    <td class="tg-c3ow">800</td>
  </tr>
  <tr>
    <td class="tg-c3ow">高清</td>
    <td class="tg-c3ow">10</td>
    <td class="tg-c3ow">1280 × 720</td>
    <td class="tg-c3ow">1400</td>
  </tr>
  <tr>
    <td class="tg-0pky" rowspan="2">场景 3: 较复杂的高帧游戏<br></td>
    <td class="tg-0pky" rowspan="2">枪战类游戏<br><br>如和平精英</td>
    <td class="tg-c3ow">流畅<br></td>
    <td class="tg-c3ow">24<br></td>
    <td class="tg-c3ow">840 × 480<br></td>
    <td class="tg-c3ow">1400 ~ 1600<br></td>
  </tr>
  <tr>
    <td class="tg-c3ow">高清<br></td>
    <td class="tg-c3ow">24<br></td>
    <td class="tg-c3ow">1280 × 720<br></td>
    <td class="tg-c3ow">2000 ~ 2200<br></td>
  </tr>
  <tr>
    <td class="tg-0pky" rowspan="2">场景 4: 较复杂的低帧且细节丰富游戏<br></td>
    <td class="tg-0pky" rowspan="2">MOBA 类游戏<br><br>如王者荣耀</td>
    <td class="tg-c3ow">流畅<br></td>
    <td class="tg-c3ow">15<br></td>
    <td class="tg-c3ow">840 × 480<br></td>
    <td class="tg-c3ow">1000 ~ 1200<br></td>
  </tr>
  <tr>
    <td class="tg-c3ow">高清<br></td>
    <td class="tg-c3ow">15<br></td>
    <td class="tg-c3ow">1280 × 720<br></td>
    <td class="tg-c3ow">1600 ~ 1800<br></td>
  </tr>
  <tr>
    <td class="tg-0pky" rowspan="2">场景 5: 较复杂的低帧且细节单一游戏<br></td>
    <td class="tg-0pky" rowspan="2">塔防类游戏<br><br>捕鱼类游戏<br><br><span style="font-weight:normal;font-style:normal;text-decoration:none">如植物大战僵尸</span><br></td>
    <td class="tg-c3ow">流畅<br></td>
    <td class="tg-c3ow">15</td>
    <td class="tg-c3ow">640 × 360<br></td>
    <td class="tg-c3ow">800 ~ 1000<br></td>
  </tr>
  <tr>
    <td class="tg-c3ow">高清<br></td>
    <td class="tg-c3ow">15</td>
    <td class="tg-c3ow">840 × 480<br></td>
    <td class="tg-c3ow">1400 ~ 1600<br></td>
  </tr>
</tbody>
</table>

