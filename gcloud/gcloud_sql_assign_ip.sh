#!/bin/sh
gcloud sql instances patch maindb --assign-ip
gcloud sql instances list
