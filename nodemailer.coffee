nodemailer = require("nodemailer")
# 开启一个 SMTP 连接池


smtpTransport = nodemailer.createTransport({
  host: "smtp.qq.com" # 主机
  port: 465 # SMTP 端口
  secure: true # 使用 SSH
  auth:
    user: "1012004860@qq.com" # 账号
    pass: "" # 密码
})
# 设置邮件内容
To = [
  "450978053@qq.com"
, "lizhenplus@foxmail.com"
, "280835372@qq.com"
, "constroy@163.com"
, "keepit_lch@163.com"
, "superheyueaaa@163.com"
, "linziyi@buaa.edu.cn"
, "fate_wheel@126.com"
, "1440634039@qq.com"
, "1023964019@qq.com"
]

Name = [
  "TheWaySoFar"
, "Damocles"
, "undetermined"
, "TDL"
, "LovelyDonuts"
, "NewBeer"
, "TheThreeMusketeers"
, "I-PPPei+"
, "Prometheus"
, "null"
]

Team = [
  "team0235@pkuicpc.cn"
,
  "team0236@pkuicpc.cn"
,
  "team0237@pkuicpc.cn"
,
  "team0238@pkuicpc.cn"
,
  "team0239@pkuicpc.cn"
,
  "team0240@pkuicpc.cn"
,
  "team0241@pkuicpc.cn"
,
  "team0242@pkuicpc.cn"
,
  "team0243@pkuicpc.cn"
,
  "team0244@pkuicpc.cn"
,
  "team0245@pkuicpc.cn"
,
  "team0246@pkuicpc.cn"
,
  "team0247@pkuicpc.cn"
]

Pass = [
  "5200262paw"
,
  "qghwpb1fwo"
,
  "eu0vs9zp3g"
,
  "r9i790drpn"
,
  "3wjks8v93s"
,
  "xi2xdamszq"
,
  "96f7d4oqvt"
,
  "tzpczh0v64"
,
  "33mlgzv38v"
,
  "9hhoovsc13"
,
  "6bibni94tf"
,
  "8cjuxz9six"
,
  "3relvjw3bd"
]
record = 0
for i in [0...Name.length]
  mailOptions = {
    from: "梁明阳<1012004860@qq.com>" # 发件地址
    to: "#{Name[i]}<#{To[i]}>" #收件列表
    subject: "ACM-ICPC:北京网络赛账号和密码" #标题
    html: "Hi，#{Name[i]}，这是你们队的账号和密码<br><br><b>账号：#{Team[i]}</b><br><b>密码：#{Pass[i]}</b><br><br>北京网络赛将于2015-09-20 12:00:00在<a href=\"http://acm.pku.edu.cn/icpc_pku2015/\">Hihocoder</a>上进行，大家可以提前适应一下hihocoder的比赛环境。<br><br>不要作弊，会有监察的。<br>注意保管账号和密码，<b>预祝你们取得好成绩，收到请回复</b><br><br>------------------<br>发送自：梁明阳<br>手机：13146014364<br>邮箱：1012004860@qq.com<br>QQ：1012004860<br>" #html 内容
  }
  # 发送邮件
  smtpTransport.sendMail mailOptions, (err, res)->
    if(err)
      console.log err, res
    else
      console.log res
    ++record

setInterval(->
  if record >= To.length
    console.log "Done"
  else
    console.log "Waiting"
, 2000
)
#while(true)
#  if record >= TO.length
#    console.log "Done"
#    break
#smtpTransport.close()
#
#smtpTransport.sendMail(mailOptions, function(error, response){
#  if(error){
#  console.log(error);
#}else{
#console.log("Message sent: " + response.message);
#}
#smtpTransport.close(); // 如果没用，关闭连接池
#});