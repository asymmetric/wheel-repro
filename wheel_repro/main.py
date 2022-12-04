import panel as pn

def main():
    pn.extension()
    window = pn.widgets.IntSlider(name='window', value=30, start=1, end=60)
    print("ok")

if __name__ == "__main__":
    main()
