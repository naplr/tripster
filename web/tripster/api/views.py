from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

from .models import Post

import uuid

from PIL import Image
from django.views.decorators.csrf import csrf_exempt


def index(request):
    return HttpResponse('hello world')


def _get_image_from_post_files(files, input_name):
        image = files.get(input_name, None)

        # Give an image a new unique name
        if image is not None:
            ext = image.name[image.name.rfind('.'):]
            image.name = '{}{}'.format(uuid.uuid1(), ext)

        return image


@csrf_exempt
def add_post(request):
    if request.method == 'POST':
        print(request.POST)
        print("========")
        print(request.FILES)

        username = request.POST['username']
        latitude = request.POST['latitude']
        longitude = request.POST['longitude']
        creation_date = request.POST['creationDate']

        image = _get_image_from_post_files(request.FILES, 'profile_img')

        post = Post(image_date=creation_date, latitude=latitude, longitude=longitude, image=image, username=username)
        post = Post(latitude=latitude, longitude=longitude, image=image, username=username)
        post.save()

    return HttpResponse('add post')


@csrf_exempt
def check_location(request):
    if request.method == 'POST':
        print(request.POST)

        latitude = request.POST['latitude']
        longitude = request.POST['longitude']

        for p in Post.objects.all():
            if _check_distance(latitude, longitude, p.latitude, p.longitude):
                return JsonResponse({'found': 'TRUE', 'image_url': p.image.url, 'username': p.username})

        return JsonResponse({'found': 'FALSE'})


def _check_distance(xla, xlo, yla, ylo):
    if abs(yla-float(xla)) < 1 and abs(ylo-float(xlo)) < 1:
        return True


def get_post(request):
    return HttpResponse('get post')


# def upload_pic(request):
#     if request.method == 'POST':
#         form = ImageUploadForm(request.POST, request.FILES)
#
#         if form.is_valid():
#             # m = ItemImage.objects.get(pk=course_id)
#             m = ItemImage()
#             m.name = uuid.uuid1() # Generate a new unique name.
#
#             # Rename the file but keep the type.
#             m.image = form.cleaned_data['image']
#             filetype = m.image.name[m.image.name.rfind('.'):]
#             m.image.name = '{}{}'.format(m.name, filetype)
#             m.save()
#
#             image.save(m.image.path)
#
#             return JsonResponse({'image_id': m.name, 'image_url': m.image.url})
#     return HttpResponseForbidden('allowed only via POST')
