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
  "constroy@163.com",
  "keepit_lch@163.com",
  "linziyi@buaa.edu.cn",
  "1023964019@qq.com",
  "andy_usaco@126.com",
  "412962834@qq.com",
  "350012950@qq.com",
  "superheyueaaa@163.com",
  "1808160349@qq.com",
  "342333349@qq.com",
  "450978053@qq.com",
  "geaed@126.com"
]

Name = [
  "TDL",
  "LovelyDonuts",
  "ACMakeMeHappier",
  "null",
  "sto orz",
  "QAQ",
  "ResuscitatedHope",
  "deticxe",
  "GG",
  "The South China Sea belongs to China!",
  "昂神",
  "适牛"
]

Team = [
  "team160812@pkuicpc.cn",
  "team160813@pkuicpc.cn",
  "team160814@pkuicpc.cn",
  "team160815@pkuicpc.cn",
  "team160816@pkuicpc.cn",
  "team160817@pkuicpc.cn",
  "team160818@pkuicpc.cn",
  "team160819@pkuicpc.cn",
  "team160820@pkuicpc.cn",
  "team160821@pkuicpc.cn",
  "team160822@pkuicpc.cn",
  "team160823@pkuicpc.cn",
  "team160824@pkuicpc.cn",
  "team160825@pkuicpc.cn",
  "team161018@pkuicpc.cn"
]

Pass = [
  "TM6O4F0CRB",
  "J4HV4499XQ",
  "K6FIZFOU4T",
  "6NMJ1WO7YM",
  "87GF8Q98QD",
  "4GPPOEVIEP",
  "HRIT09FE7K",
  "QLXD7CTMQP",
  "PKV409P1H9",
  "WPQ4OGJA1G",
  "KX8NG5PGH5",
  "VDWHN2WI9K",
  "IVZY5TLETS",
  "1JVFX2AC8X",
  "NFOD1KN0LU"
]
record = 0

mailOptions = []
send = (i)->
  setTimeout(->
    smtpTransport.sendMail mailOptions[i], (err, res)->
      if(err)
        console.log err, res
        console.log "#{Name[i]}发送失败"
      else
        console.log res
        console.log "#{Name[i]}发送成功"
      ++record
  , i*1000)
for i in [0...Name.length]
  mailOptions.push {
    from: "梁明阳<1012004860@qq.com>" # 发件地址
    to: "#{Name[i]}<#{To[i]}>" #收件列表
    #to: "lmysoar@hotmail.com"
    subject: "BCPC:北京网络赛账号和密码" #标题
    html: "Hi，#{Name[i]}，这是你们的北京网络赛的账号和密码<br><br><b>账号：#{Team[i]}</b><br><b>密码：#{Pass[i]}</b><br><br>北京网络赛将于2016-09-24 12:00:00在<a href='https://hihocoder.com/contests'>hihocoder</a>上进行。<br><br>不要作弊，会有监察的。<br>注意保管账号和密码，<b>预祝你们取得好成绩，收到请回复</b><br><br>------------------<br>发送自：梁明阳<br>手机：13146014364<br>邮箱：1012004860@qq.com<br>QQ：1012004860<br>" #html 内容
  }
  # 发送邮件
for i in [0...Name.length]
  send(i)

setInterval(->
  if record >= To.length
    console.log "Done! you can close me"
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