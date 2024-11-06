from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess

class RequestHandler(BaseHTTPRequestHandler):
  def do_POST(self):
    # 执行部署脚本 
    subprocess.Popen(['/home/ubuntu/project/gin-vue-admin/deploy.sh'])
    self.send_response(200)  # 发送 HTTP 200 响应
    self.end_headers()  # 结束 HTTP 头部

if __name__ == "__main__":
  # 创建 HTTP 服务器，监听 0.0.0.0:8000 // 0.0.0.0 代表监听所有网卡 
  server = HTTPServer(('0.0.0.0', 8000), RequestHandler)
  print('Starting server on port 8000...')
  server.serve_forever()  # 启动服务器，开始处理请求