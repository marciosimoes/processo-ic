import requests
import zipfile
import urllib.request
from bs4 import BeautifulSoup

url = requests.get('https://www.gov.br/ans/pt-br/assuntos/consumidor/o-que-o-seu-plano-de-saude-deve-cobrir-1/o-que-e-o-rol-de-procedimentos-e-evento-em-saude')
soup = BeautifulSoup(url.content,"lxml")

anexos = ["Anexo I", "Anexo II", "Anexo III", "Anexo IV"]
urls = []

for a in soup.select("[href$='.pdf']"):
    for anexo in anexos:
        if anexo in a.get_text():
            urls.append(a['href'])
            anexos.remove(anexo)

with zipfile.ZipFile("download_pdfs.zip", "w") as zip:
    for url in urls:
        response = urllib.request.urlopen(url)
        pdf_file = response.read()
        zip.writestr(url.split("/")[-1], pdf_file)
