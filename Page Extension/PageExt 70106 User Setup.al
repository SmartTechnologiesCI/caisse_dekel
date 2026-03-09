pageextension 70106 "User Setup" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field(EnAttentePaiement; EnAttentePaiement)
            {
                ApplicationArea = All;
            }
            field(AutorisationAnnulation; AutorisationAnnulation)
            {
                ApplicationArea = All;
            }
            field(CL; REC.CL)
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                    MagasinCentreLogistique: Record MagasinCentreLogistique;
                begin
                    MagasinCentreLogistique.SetRange(Prefixe, rec.CL);
                    if MagasinCentreLogistique.FindFirst() then begin
                        rec.DescriotionCL := MagasinCentreLogistique.Description;
                        rec.Modify();
                    end else begin
                        rec.DescriotionCL := '';
                        rec.Modify();
                    end;

                end;

            }
            field(DescriotionCL; rec.DescriotionCL)
            {
                ApplicationArea = All;
            }
            field(Annule; REC.Annule)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}