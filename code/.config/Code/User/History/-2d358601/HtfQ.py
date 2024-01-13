import pandas as pd

def raw(csv):
    df = pd.read_csv(csv, encoding='latin-1')

    cols = ['Material', 'Prod. order', 'Complaint qty', 'Unit', 'Category', 'Sub Category', 'Decision', 'Division']

    df2=(df
    .dropna(subset='Notification')
    .assign(
        material_number=df.Material.fillna(0),
        prod_order=df['Prod. order'].fillna(0),
        complaint_qty=df['Complaint qty'].fillna(0),
        sub_category=df['Sub Category'].fillna('NA'),
        division=df.Division.fillna('Operations'),
        unit=df.Unit.fillna('NA'),
        category=df.Category.fillna('Other'),
        decision=df.Decision.fillna('Immediate action - Correction'))
    .drop(columns=cols)
    .rename(columns={'CCP/oPRP':'risk', 'Work Station':'work_station', 'Material Number':'material', 'Task text':'task_text'})
    .rename(columns=str.lower)
    .astype({'notification': int, 'prod_order': int, 'material_number': int})
    .astype({'decision': 'category', 'division': 'category', 'department': 'category', 'unit': 'category', 'category': 'category',
            'sub_category': 'category', 'coding': 'category', 'status': 'category', 'risk': 'category', 'work_station': 'category'})
    )

    devcons=(df2[(df2.decision == 'Deviation') | (df2.decision == 'Concession')]
    .drop_duplicates(subset='notification')
    )

    result=(pd.concat([devcons,df2])
    .drop_duplicates(subset='notification')
    )

    return result
