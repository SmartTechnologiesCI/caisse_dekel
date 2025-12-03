page 70121 ListePantPlanteurArchive
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    SourceTable = Entete_Paiement;
    SourceTableView = where(Archive = const(true));
    CardPageId = ArchiEntetePlanteur;
    Caption = 'Archive Paiement Planteur';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(NumDocExt; NumDocExt)
                {
                    ApplicationArea = All;
                }

                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Palanteur; Palanteur)
                {
                    ApplicationArea = All;
                }
                field(Nom_Planteur; Nom_Planteur)
                {
                    ApplicationArea = All;
                }
                field(Date_Paiement; Date_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Beneficiare; Beneficiare)
                {
                    ApplicationArea = ALL;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Imprimer)
            {
                Caption = 'Imprimer Ticket';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()

                var
                    Entete_Paiements: Record Entete_Paiement;
                    itemWigIfbhhf: Record "Item Weigh Bridge";
                begin
                    itemWigIfbhhf.SetRange(NumDocExten, REC.NumDocExt);
                    if itemWigIfbhhf.FindFirst() then begin
                        Report.Run(70050, true, false, itemWigIfbhhf);
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter(Archive, '=%1', true);
    end;

    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        // RUN(Page::ListePaiementPlanteur)
    end;
}