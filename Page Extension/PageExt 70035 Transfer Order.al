pageextension 70035 "Transfer OrderExt" extends "Transfer Order"
{
    layout
    {
        addbefore(General)
        {
            group(Article)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Caption = 'N° Article';
                    trigger OnValidate()
                    var
                        // item: record Item;
                        achetes: Integer;
                        vendu: Integer;
                        stock: Integer;
                    begin
                        // item.SetRange(loc, '%1', rec."Location Code");
                        // item.SetRange("No.", rec."Item No.");
                        // if item.FindFirst() then begin
                        //     // item.CalcFields("Cartons achetés");
                        //     // item.CalcFields("Cartons vendus");
                        //     // achetes := -item."Cartons achetés";
                        //     // vendu := item."Cartons vendus";
                        //     // stock := -(item."Cartons achetés" + item."Cartons vendus");
                        //     // item."Nombre cartons" := stock;
                        //     rec.Description := item.Description;
                        //     item.CalcFields("Cartons Solde");
                        //     rec."Cartons total" := item."Cartons Solde";
                        //     item.CalcFields(Inventory);
                        //     rec."Qunatité Totale" := item.Inventory;
                            // rec."curr Carton Mag" := item.ItemCartonStokbyMagasin(rec."Location Code");
                            // rec."curr Quantity Mag" := item.ItemQuantityStockbyMagasin(rec."Location Code");
                        // silue samuel 07/03/2025 end;
                    end;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cartons total"; rec."Cartons total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Qunatité Totale"; rec."Qunatité Totale")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
            }
        }
        addafter("Transfer-from Code")
        {

            field(PoidsActuelmagasinOrigine; rec.PoidsActuelmagasinOrigine)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(CartonsActuelmagasinOrigine; rec.CartonsActuelmagasinOrigine)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Transfer-to Code")
        {
            field(PoisActuelMagasinDestination; rec.PoisActuelMagasinDestination)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("CartonsActuelMagasinDestinat."; rec."CartonsActuelMagasinDestinat.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Transfer-from Code")
        {
            // Caption = 'Code magasin';
            ShowMandatory = true;
            Style = Unfavorable;


            trigger OnBeforeValidate()
            var
                // silue samuel 07/03/2025item: record Item;
                achetes: Integer;
                vendu: Integer;
                stock: Integer;
            begin
                // item.SetRange(loc, '%1', rec."Location Code");
                // item.SetRange("No.", rec."Item No.");
                // if item.FindFirst() then begin
                    // item.CalcFields("Cartons achetés");
                    // item.CalcFields("Cartons vendus");
                    // achetes := -item."Cartons achetés";
                    // vendu := item."Cartons vendus";
                    // stock := -(item."Cartons achetés" + item."Cartons vendus");
                    // item."Nombre cartons" := stock;
                    // rec.Description := item.Description;
                    // item.CalcFields("Cartons Solde");
                    // rec."curr Carton" := item."Cartons Solde";
                    // item.CalcFields(Inventory);
                    // rec."curr Quantity" := item.Inventory;
                    // rec.CartonsActuelmagasinOrigine := item.ItemCartonStokbyMagasin2(rec."Transfer-from Code");
                    // rec.PoidsActuelmagasinOrigine := item.ItemQuantityStockbyMagasin(rec."Transfer-from Code");
                    // Message('a:%1 b:%2', rec.CartonsActuelmagasinOrigine, rec.PoidsActuelmagasinOrigine);
                // end;
            end;

        }
        modify("Transfer-to Code")
        {
            ShowMandatory = true;
            Style = Favorable;
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                // item: record Item;
                achetes: Integer;
                vendu: Integer;
                stock: Integer;
            begin
                // item.SetRange(loc, '%1', rec."Location Code");
                // item.SetRange("No.", rec."Item No.");
                // if item.FindFirst() then begin
                //     // item.CalcFields("Cartons achetés");
                //     // item.CalcFields("Cartons vendus");
                //     // achetes := -item."Cartons achetés";
                //     // vendu := item."Cartons vendus";
                //     // stock := -(item."Cartons achetés" + item."Cartons vendus");
                //     // item."Nombre cartons" := stock;
                //     // rec.Description := item.Description;
                //     // item.CalcFields("Cartons Solde");
                //     // rec."curr Carton" := item."Cartons Solde";
                //     // item.CalcFields(Inventory);
                //     // rec."curr Quantity" := item.Inventory;
                //     rec."CartonsActuelMagasinDestinat." := item.ItemCartonStokbyMagasin2(rec."Transfer-to Code");
                //     rec.PoisActuelMagasinDestination := item.ItemQuantityStockbyMagasin(rec."Transfer-to Code");
                //     // Message('a:%1 b:%2', rec.CartonsActuelmagasinOrigine, rec.PoidsActuelmagasinOrigine);
                // end;

            end;
        }

    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                // itemLedgerEntry: Record "Item Ledger Entry";
                TransferReceiptLine: Record "Transfer Receipt Line";
                TransferLine: Record "Transfer Line";
                rec: Record "Transfer Header";
                TransferReceiptHeader: Record "Transfer Receipt Header";
            begin

            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
                // itemLedgerEntry1: Record "Item Ledger Entry";
                TransferReceiptLine: Record "Transfer Receipt Line";
                TransferLine: Record "Transfer Line";
                rec: Record "Transfer Header";
                TransferReceiptHeader: Record "Transfer Receipt Header";
                TransferReceiptLineTempory: Record "Transfer Receipt Line Tempory";
            begin

            end;

        }
    }
    // procedure ItemCartonStokbyMagasin(magasin: Code[20]): Integer
    // var
    //     myInt: Integer;
    //     // itemLedgerEntry: Record "Ecriture cartons articles";
    //     som: Integer;
    //     itemLedgerEntry:Record "Item Ledger Entry";
    // begin
    //     Clear(itemLedgerEntry);
    //     itemLedgerEntry.Reset();
    //     itemLedgerEntry.SetRange("Item No", rec."No.");
    //     itemLedgerEntry.SetRange("Location Code", magasin);
    //     itemLedgerEntry.CalcSums("Nombre de carton");
    //     exit(itemLedgerEntry."Nombre de carton");


    // end;

    var
        myInt: Integer;
}