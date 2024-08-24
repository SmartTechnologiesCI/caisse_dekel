table 70022 "Peseur"
{
    Caption = 'Peseur';

    fields
    {
        field(1; "Team Code"; Code[10])
        {
            Caption = 'Team Code';
            NotBlank = true;
            TableRelation = Team;
        }
        field(2; "Code Peseur"; Code[20])
        {
            Caption = 'Code Peseur';
            NotBlank = true;
            TableRelation = "User App";
        }
        field(3; "Team Name"; Text[50])
        {
            CalcFormula = Lookup (Team.Name WHERE(Code = FIELD("Team Code")));
            Captionml =ENU= 'Team Name', FRA='Nom Equipe';
            Editable = false;
            FieldClass = FlowField;
        }
     
    }

    keys
    {
        key(Key1; "Team Code", "Code Peseur")
        {
            Clustered = true;
        }
        key(Key2; "Code Peseur")
        {
        }
    }

    fieldgroups
    {
    }
}

