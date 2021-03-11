from typing import Union

from django.shortcuts import render
from django.http.request import HttpRequest
from django.http.response import HttpResponse, HttpResponseBadRequest
from django.views.decorators.http import require_GET


@require_GET
def display_personal_code(
    request: HttpRequest,
) -> Union[HttpResponse, HttpResponseBadRequest]:
    code: str = request.GET.get("code", "")

    if not code or not len(code):
        return HttpResponseBadRequest("Invalid request")

    return render(request, "personal-code.html", {"code": code})
