tableextension 70008 "Sales setup" extends 311
{
    fields
    {

        // Add changes to table fields here
        field(70000; "Montant epargne"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70002; "Montant epargne Max"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Type epargne"; Option)
        {
            OptionMembers = "CARTON","POIDS";
        }
    }

    var
        myInt: Integer;

}