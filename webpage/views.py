from django.shortcuts import render

# Create your views here.
def home(request):
    return render(request, 'index.html')

def generic(request):
    return render(request, 'generic.html')

def elements(request):
    return render(request, 'elements.html')
