page 70170 ValidationFournisseur
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Cue";

    layout
    {
        area(Content)
        {
            cuegroup(ValidationFournisseur)
            {
                Caption = 'Validation fournisseur';
                field(FournisseurEnAttenteValidation; rec.FournisseurEnAttenteValidation)
                {

                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Vendor: Record Vendor;
                    begin
                        Vendor.SetRange(Statut, Vendor.Statut::Nouveau);
                        if Vendor.FindFirst() then begin
                            PAGE.Run(27, Vendor);
                        end;
                    end;

                }
                field(FournisseurValide; REC.FournisseurValide)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        Vendor: Record Vendor;
                    begin
                        Vendor.SetRange(Statut, Vendor.Statut::"Validé");
                        if Vendor.FindFirst() then begin
                            PAGE.Run(27, Vendor);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}