FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-runtime

WORKDIR /

# nvidia rotated their GPG keys so need to refresh them 
# Install git
RUN apt-get update && apt-get install -y git

# Install python packages
RUN pip3 install --upgrade pip
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Add your model weight files 
# (in this case we have a python script)
ADD download.py .
RUN python3 download.py

ADD / .

EXPOSE 8000

CMD python3 -u app.py --no-reload
