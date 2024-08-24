page 70001 "Paramètres caisses"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Parametres caisse";
    //InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field("N° souche Ouverture"; "N° souche Ouverture")
                {
                    ApplicationArea = All;

                }
                field("N° souche Mouvement"; "N° souche Mouvement")
                {
                    ApplicationArea = All;

                }
                field("N° souche clôture"; "N° souche clôture")
                {
                    ApplicationArea = All;

                }

                field("N° souche Depot"; "N° souche Depot")
                {
                    ApplicationArea = All;

                }

                field("N° compte caisse"; "N° compte caisse")
                {
                    ApplicationArea = All;

                }

                field("N° compte coffre fort"; "N° compte coffre fort")
                {
                    ApplicationArea = All;

                }

                field("N° compte banque cheque"; "N° compte banque cheque")
                {
                    ApplicationArea = All;

                }

                field("N° compte banque virement"; "N° compte banque virement")
                {
                    ApplicationArea = All;

                }
                field("N° compte banque CB"; "N° compte banque CB")
                {
                    ApplicationArea = All;

                }
                field("N° compte banque diverse"; "N° compte banque diverse")
                {
                    ApplicationArea = All;

                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Billets)
            {
                ApplicationArea = All;
                Image = Currencies;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 70025;
            }
            action(DeleteAll){
                trigger OnAction()
                var
                    cu70000: Codeunit 70000;
                begin
                    cu70000.DeleteElements();
                end;
            }
        }
    }
    trigger OnNewRecord(belowxrec: boolean)
    var
        myInt: Integer;
    begin
        if (FindFirst()) then
            Error('Paramètre caisse existe déjà');
    end;

    var
        myInt: Integer;
}