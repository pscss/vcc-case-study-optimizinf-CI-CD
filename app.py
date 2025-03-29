from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return "Welcome to the SaaS Application!"


@app.route("/api/status")
def status():
    return jsonify({"status": "success", "message": "Service is running smoothly."})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
