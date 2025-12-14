tableextension 70031 "User Setup" extends "User Setup"
{
    fields
    {
        field(5000; EnAttentePaiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Autorisation ticket en attente paiement';
        }
        field(50001; AutorisationAnnulation; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Autorisation Annulation Ticket';

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