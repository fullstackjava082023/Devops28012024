from flask import Flask, request, jsonify, Response
import requests
import socket

app = Flask(__name__)

request_count = 0

@app.route('/', methods=['GET'])
def hello():
    global request_count
    request_count += 1 

    # get the hostname and ip from the socket
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    public_ip = get_public_ip()
    public_ip2 = request.headers.get('Host')
    user_ip = request.remote_addr
    
    response = (f'Hello, World!, the number of requests is: {request_count}\n'
                f'Hostname: {hostname}\n'
                f'IP Address: {ip_address}\n'
                f'Public IP Address: {public_ip}\n'
                f'Public IP Address from request header: {public_ip2}\n'
                f'User IP Address: {user_ip}\n')
    
    

    return Response(response, mimetype='text/plain')

@app.route('/hello', methods=['GET'])
def say_hello():
    return 'Hello, World!'


def get_public_ip():
    try:
        response = requests.get('https://api64.ipify.org?format=json')
        response.raise_for_status()
        return response.json()["ip"]
    except requests.RequestException as e:
        return f"Error: Unable to determine public IP. {e}"

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)