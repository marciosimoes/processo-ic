import zipfile
import io
import pandas as pd
from tabula import read_pdf

with zipfile.ZipFile('download_pdfs.zip', 'r') as zip_ref:
    pdf_file = zip_ref.open('Anexo_I_Rol_2021RN_465.2021_RN473_RN478_RN480_RN513_RN536_RN537_RN538_RN539_RN541_RN542_RN544_546.pdf')
    df = read_pdf(io.BytesIO(pdf_file.read()), pages='all', multiple_tables=False)
    tabela = df[0]

replacements = {'OD': 'Seg. Odontológica', 'AMB': 'Seg. Ambulatorial'}

tabela.replace(replacements, inplace=True)

with zipfile.ZipFile('Teste_Marcio.zip', 'w') as zip_file:
    tabela.to_csv(zip_file.open('tabela.csv', 'w'))
