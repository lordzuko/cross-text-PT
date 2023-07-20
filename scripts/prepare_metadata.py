import pandas as pd


df = pd.read_csv("/work/tc046/tc046/lordzuko/data/blizzard_2013/BC2013_seg_v1/trainset-transcript.csv", delimiter="|")
df.columns = ["wavfile", "abc", "text", "cde"]
df = df[["wavfile", "text"]]

filename = "/scratch/space1/tc046/lordzuko/work/data/raw_data/BC2013_daft_orig/CB/metadata.csv"
with open(filename, 'w', newline='') as f:
    l = []
    for i, r in df.iterrows():
        l.append(f"{r['wavfile']}|{r['text']}\n")
    f.writelines(l)