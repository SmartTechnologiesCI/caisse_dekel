tableextension 70013 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(70000; "Autorisation de change"; Code[100])
        {
            Caption = 'Autorisation de change';
            DataClassification = ToBeClassified;
        }

        field(70001; "Banque"; Code[100])
        {
            Caption = 'Banque';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}