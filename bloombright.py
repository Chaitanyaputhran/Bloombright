import numpy as np
from flask import Flask, request, jsonify
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from flask_cors import CORS


app = Flask(__name__)
CORS(app)  

# Sample dataset (Replace this with a larger and more diverse dataset)
data = [
   {'color': 'dark red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle seems to be generally regular with minor variations, but no major health issues are observed.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle shows some minor irregularities, but there is no evidence of any major underlying health conditions.'},
    # Additional data below
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle seems to be generally regular with minor variations, but no major health issues are observed.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle shows some minor irregularities, but there is no evidence of any major underlying health conditions.'},
       {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'bright red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    # Add more health_status variations below
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle seems to be generally regular with minor variations, but no major health issues are observed.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle shows some minor irregularities, but there is no evidence of any major underlying health conditions.'},
      {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle seems to be generally regular with minor variations, but no major health issues are observed.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle shows some minor irregularities, but there is no evidence of any major underlying health conditions.'},
    # More data below
    {'color': 'bright red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle shows some minor irregularities, but there is no evidence of any major underlying health conditions.'},
      {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    # More data below
    {'color': 'bright red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'dark red', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'bright red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'brown', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
     {'color': 'bright red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'dark red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': False, 'spotting': True, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    # More data below
    {'color': 'dark red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
     {'color': 'dark red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
    # More data below
    {'color': 'dark red', 'period_length': 3, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle displays irregular patterns in terms of timing, duration, or flow, and may warrant further attention or investigation for potential underlying health concerns.'},
    {'color': 'brown', 'period_length': 5, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': True, 'spotting': True, 'health_status': 'Overall, the menstrual cycle appears healthy and within normal parameters.'},
    {'color': 'bright red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': False, 'spotting': False, 'health_status': 'No significant health concerns are evident in the menstrual cycle.'},
    {'color': 'dark red', 'period_length': 4, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'light', 'clotting': True, 'spotting': False, 'health_status': 'While some irregularity is present, no alarming health issues are apparent in the menstrual cycle.'},
    {'color': 'brown', 'period_length': 6, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'moderate', 'clotting': False, 'spotting': False, 'health_status': 'The menstrual cycle shows mild irregularity, but it is not indicative of any major health problems.'},
    {'color': 'bright red', 'period_length': 5, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': True, 'health_status': 'The menstrual cycle displays slight irregular patterns, but there are no signs of serious health issues.'},
    {'color': 'dark red', 'period_length': 7, 'irregular': False, 'menstrual_pain': 'severe',
     'flow_amount': 'heavy', 'clotting': True, 'spotting': True, 'health_status': 'Minor fluctuations are noticed in the menstrual cycle, but they do not raise any red flags for health concerns.'},
    {'color': 'brown', 'period_length': 4, 'irregular': True, 'menstrual_pain': 'moderate',
     'flow_amount': 'light', 'clotting': False, 'spotting': False, 'health_status': 'Some variations in the menstrual cycle are observed, but they do not seem to be associated with significant health problems.'},
    {'color': 'bright red', 'period_length': 6, 'irregular': False, 'menstrual_pain': 'mild',
     'flow_amount': 'moderate', 'clotting': True, 'spotting': False, 'health_status': 'The menstrual cycle appears to be regular and without any notable health concerns.'},
]
     
import pandas as pd
df = pd.DataFrame(data)     


X = df[['color', 'period_length', 'irregular', 'menstrual_pain', 'flow_amount', 'clotting', 'spotting']]
y = df['health_status']


# Encode categorical features using LabelEncoder
label_encoders = {}
for feature in X.select_dtypes(include=['object']):
    le = LabelEncoder()
    X.loc[:, feature] = le.fit_transform(X.loc[:, feature])
    label_encoders[feature] = le




# Create and train the model
model = RandomForestClassifier(random_state=42)
model.fit(X, y)




def preprocess_input(user_input):
    transformed_input = user_input.copy()
    for feature, le in label_encoders.items():
        transformed_input[feature] = le.transform([user_input[feature]])[0]
    return transformed_input

# Function to predict menstrual health
def predict_health(user_input):
    transformed_input = preprocess_input(user_input)
    prediction = model.predict([list(transformed_input.values())])[0]
    return prediction

# Main function to interact with the user
@app.route('/predict', methods=['POST'])
def predict():
    try:
        user_input = request.json
        health_status = predict_health(user_input)
        return jsonify({'health_status': health_status})  # Return the result as JSON
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == "__main__":
    app.run(debug=True)