from fastapi import FastAPI
import psutil

app = FastAPI(title="Welcome to DevSecOps-B03")


@app.get("/test")

def test():
    """ 
This endpoint just for testing
"""
    return {"message": "Welcome to DevSecOps-b03" }

@app.get("/metrics")
def metrics():
    """
    This endpoints shows information about host system
    """
    cpu = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory().percent
    disk = psutil.disk_usage("/").percent


    sys_info = {
        "cpu_usage": cpu,
        "memory_usage": memory,
        "disk_usage": disk
    }

    # print(sys_info)
    return sys_info




