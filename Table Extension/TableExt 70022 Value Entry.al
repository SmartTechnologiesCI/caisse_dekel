tableextension 70022 "Value EntryExt" extends "Value Entry"
{
    fields
    {
        field(50004; "Nombre de cartonc"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Nombre de carton (constaté)';
            Description = 'Ce cahmp est dédié à la saisie mannuelle du nombre de carton physique constaté dans le stock';
        }
        field(50005; "Diff Qty carton"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Diff Qty carton';
            Description = 'Spécifie le nombre d''unités de carton de  l''article à inclure sur la ligne feuille.';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}