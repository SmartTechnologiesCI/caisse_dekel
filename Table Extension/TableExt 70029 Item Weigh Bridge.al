tableextension 70029 "Item Weigh Bridge" extends "Item Weigh Bridge"
{
    fields
    {
        field(55005; Statut_Total_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entièrement payé';
        }
        field(55006; Ticket_Concerne; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s) Planteur';
        }
        field(55007; NumDocExten; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(55008; Telephone; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(55009; En_Attente_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'En attente de paiement';
            trigger OnValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup.TestField(UserSetup.EnAttentePaiement, true);
                end;
            end;
        }
        field(55010; TotalPlanteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur (FCFA)';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55011; Impot; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Impôt 1,5 %';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55012; TotalPlanteurTTc; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur(TTC:) FCFA';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55013; TotalTransPorteurTTC; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat Transporteur (TTC:) FCFA';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55014; Poids_Total; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Poids Total';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55015; Ticket_Concerne_Transport; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s) Transporteur';
        }
        field(55016; PrixUnitaire; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix unitaire(FCFA)';
            DecimalPlaces = 6;
            Editable = false;
        }
        field(55017; Marqueur; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55018; NaturePiece; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'NATURE DE LA PIECE';
            OptionMembers = CNI,PASSEPORT,PERMIS,CS,AUTRES;
        }
        field(55019; PrixUnitaireTansport; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix unitaire Transport(FCFA)';
            DecimalPlaces = 6;
            Editable = FALSE;
        }
        field(55020; MarqueurTransport; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55021; TotalTransporteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat Transport (FCFA)';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55022; TestToal; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(55023; Annule; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Envoyé en annulation","Annulation refusée","Annulé";

            // Caption = 'Annulé';
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
    procedure AssistEdit_PaiementCaisse(OldPoint: Record "Item Weigh Bridge"): Boolean;
    var
        Balance: Record "Parametres caisse";
        TicketPlanteur: Code[100];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Vérifier qu'une balance est sélectionnée
        // Rec.TestField(NU);
        Balance.Get();
        // Balance.SetRange(Code, Rec."Balance Code");
        if not Balance.FindFirst() then
            Error('Renseignement la souche de numéro paie ticket dans paramètre utilisateurs.');
        // if NoSeriesMgt.DoGetNextNo(Balance.NumSouschPaie, OldPoint."No. Series", Rec."No. Series") then begin
        //  if NoSeriesMgt.DoGetNextNo(Balance.NumSouschPaie, OldPoint."No. Series", Rec."No. Series") then begin


        TicketPlanteur :=
            NoSeriesMgt.GetNextNo(Balance.NumSouschPaie, WorkDate(), true);

        Rec.NumDocExten := TicketPlanteur;

        exit(true);
        // end else begin
        //     Error('Impossible de sélectionner la souche de numérotation "%1".', Balance.NumSouschPaie);
        // end;
    end;

    var
        myInt: Integer;
}