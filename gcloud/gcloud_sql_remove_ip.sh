#!/bin/sh
gcloud sql instances patch maindb --no-assign-ip
gcloud sql instances list
