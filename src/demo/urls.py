from django.urls import path
from . import views

urlpatterns = [path("demo/callback", views.display_personal_code)]
